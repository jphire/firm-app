# encoding: utf-8
class Bill < ActiveRecord::Base
  belongs_to :subbill, :polymorphic => true, :autosave => true
  belongs_to :client
  
  attr_accessible :delivery_type, :due_date, :total_amount, :state, :reference_number, :subbill, :client_id
  subbill_list = ["Bakerybill"]
  delivery_list = ["Posti", "Nouto"]
  state_list = ["Tilattu", "Tehty", "Laskutettu", "Maksettu", "Kirjattu"]
  validates :delivery_type, presence: { :message => "Toimitustapa on pakollinen" }
  validates_inclusion_of :delivery_type, :in => delivery_list, :allow_nil => false, :message => "Toimitustavan täytyy olla joku seuraavista: #{delivery_list}"
  validates :total_amount, presence: { :message => "Loppusumma on pakollinen" }
  validates :client, presence: { :message => "Asiakas pitää olla määritetty." }
  
  #validates :subbill_type, presence: { :message => "Laskun tyyppi on pakollinen" }
  #validates :subbill_id, presence: { :message => "Laskutyypin id on pakollinen" }
  #validates_inclusion_of :subbill_type, :in => subbill_list, :allow_nil => false, :message => "Laskutyypin täytyy olla joku seuraavista: #{subbill_list}"
  validates_numericality_of :reference_number, { :greater_than_or_equal_to => 0, :message => "Viitenumeron täytyy olla positiivinen numero!" }
  validates_inclusion_of :state, :in => state_list, :allow_nil => false, :message => "Tilan täytyy olla joku seuraavista: #{state_list}"

  def self.get_subbill_types
    ["Posti", "Nouto"] 
  end
  
  def self.get_state_list
    ["Tilattu", "Tehty", "Laskutettu", "Maksettu", "Kirjattu"]
  end
end