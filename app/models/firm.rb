# encoding: utf-8
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
class Firm < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :clients
  belongs_to :resource, :polymorphic => true, :autosave => true
  
  resource_list = ["Bakery"]
  attr_accessible :name, :corporate_id, :location, :resource
  validates :name, presence: { :message => "Nimi pakollinen" }, :length => { :minimum => 2, :maximum => 50, :message => "Nimen pituus 2-50 merkkiä" }, :uniqueness => { :message => "Yrityksen nimi on jo käytössä." }
  VALID_CORPORATE_ID_REGEX = /\d{7}-\d{1}/i
  validates :corporate_id, presence: { :message => "Y-tunnus vaaditaan" }, :length => { :minimum => 9, :maximum => 10, :message => "Y-tunnuksen täytyy olla 9 merkkiä pitkä" }, :format => { :with => VALID_CORPORATE_ID_REGEX, :message => "Y-tunnuksen täytyy olla muotoa: 1234567-8" }, :uniqueness => { :case_sensitive => false, :message => "Y-tunnus on jo käytössä." }
  validates :location, :length => { :maximum => 50, :message => "Sijainnin maksimipituus on 50 merkkiä" }
  validates :resource_type, presence: { :message => "Toimialan tyyppi pakollinen" }
  validates :resource_id, presence: { :message => "Toimialan id pakollinen" }, :uniqueness => { :message => "Toimialan yritys on jo liitetty toiseen yritykseen." }
  validates_inclusion_of :resource_type, :in => resource_list, :allow_nil => false, :message => "Toimialan täytyy olla joku seuraavista: #{resource_list}"

end
