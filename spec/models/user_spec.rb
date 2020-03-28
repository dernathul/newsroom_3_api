RSpec.describe User, type: :model do
  describe "DB table" do
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :tokens }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }

    context "should not have an invalid email adress" do
      emails = ["asdf@ ds.com", "@example.com", "test me @yahoo.com",
                "asdf@example", "ddd@.d. .d", "ddd@.d"]

      emails.each do |email|
        it { is_expected.not_to allow_value(email).for(:email) }
      end
    end

    context "should have valied email address" do
      emails = ["asdf@ds.com", "hello@example.uk", "test1234@yahoo.si",
                "asdf@example.eu"]

      emails.each do |email|
        it { is_expected.to allow_value(email).for(:email) }
      end
    end

    describe "Factory" do
      it "should have valid Factory" do
        expect(FactoryBot.create(:user)).to be_valid
      end
      it "should have valid Factary" do
        expect(FactoryBot.create(:journalist)).to be_valid
      end
    end
  end
end
