# == Schema Information
#
# Table name: firms
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  corporate_id  :string(255)
#  location      :string(255)
#  resource_id   :integer
#  resource_type :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#
# encoding: utf-8
class Firm < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :resource, :polymorphic => true, :autosave => true
  
  attr_accessible :name, :corporate_id, :location, :resource
  validates :name, presence: true, :length => { :maximum => 50 }
  VALID_CORPORATE_ID_REGEX = /\d{7}-\d{1}/i
  validates :corporate_id, presence: true, :length => { :minimum => 9, :maximum => 10 }, :format => { :with => VALID_CORPORATE_ID_REGEX }, :uniqueness => { :case_sensitive => false }
  validates :location, :length => { :maximum => 50 }
  validates :resource_type, presence: true
  validates_inclusion_of :resource_type, :in => ["Bakery"], :allow_nil => false 

end
