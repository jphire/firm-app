# == Schema Information
#
# Table name: materials
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# encoding: utf-8
require 'spec_helper'

describe Recipe do
  before { @material = Material.create(name: "Example Material") }
  after { Material.delete_all }

  subject { @material }

  it { should respond_to(:name) }
  it { should respond_to(:bakery) }
  it { should respond_to(:price) }
  
  it { should be_valid }
  
  it { should have_many(:recipes) }
  it { should have_many(:hasmaterials) }
  it { should belong_to(:bakery) }
  
  describe "when name is not present" do
    before { @material.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is already taken" do
    before { @material2 = Material.new(name: "Example Material") }
    it { @material2.should_not be_valid }
  end
  
  describe "when name is too short" do
    before { @material.name = "a" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @material.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when price is ok" do
    before { @material.price = 2.3 }
    it { should be_valid }
  end
  
  describe "when price is negative" do
    before { @material.price = -2 }
    it { should_not be_valid }
  end
  
  describe "when price is too big" do
    before { @material.price = 100000001 }
    it { should_not be_valid }
  end
  
end
