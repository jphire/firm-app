require 'spec_helper'

describe "Firm pages" do

  subject { page }

  describe "index" do
    let(:firm) { FactoryGirl.create(:firm) }
    let(:admin) { FactoryGirl.create(:admin) }
    
    before(:all) { 40.times { FactoryGirl.create(:firm) } }
    after(:all)  { Firm.delete_all }

    before(:each) do
      sign_in admin
      visit firms_path
    end

    it { should have_selector('title', text: 'Yritykset') }
    it { should have_selector('h1',    text: 'Yritykset') }
    
    describe "pagination" do

      it { should have_selector('div.pagination') }

      it "should list each firm" do
        Firm.paginate(page: 1).each do |firm|
          page.should have_selector('li', text: firm.name)
        end
      end
    end
  end
end
