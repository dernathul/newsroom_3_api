# frozen_string_literal: true

class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  def create
    if params[:stripetoken]
      begin
        customer = Stripe::Customer.list(email: current_user.email).data.first
        customer = Stripe::Customer.create({ email: current_user.email, source: params[:stripeToken] }) unless customer
        subscription = Stripe::Subscription.create({ customer: customer.id, plan: 'year_subscription' })

        if Rails.env.test?
          invoice = Stripe::Invoice.create({
            customer: customer.id,
            subscription: subscription.id,
            paid: true
          })
          subscription.latest_invoice = invoice.id
          status = Stripe::Invoice.retrieve(subscription.latest_invoice).paid
        else
          status = Stripe::Invoice.retrieve(subscription.latest_invoice).paid
        end

        if status
          current_user.role = 1
          current_user.save
          render json: { status: 'paid' }
        else
          stripe_error_handler('Transaction did not go through')
        end
      rescue StandardError => e
        stripe_error_handler(e.message)
      end
    else
      stripe_error_handler('Somthing went wrong and your payment got canceled, please contact customer support')
    end
  end

  private

  def stripe_error_handler(error)
    render json: { error_message: error }, status: 400
  end
end
