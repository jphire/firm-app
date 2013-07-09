# encoding: utf-8
class Eluate < ActiveRecord::Base

  belongs_to :huslab

  has_many :hasothers, :foreign_key => "productID"
  has_many :others, :through => :hasothers
  has_many :hasgenerators, :foreign_key => "productID"
  has_many :generators, :through => :hasgenerators
  has_many :hasstoragelocations, :foreign_key => 'item_id'
  has_many :storagelocations,  :through => :hasstoragelocations


  attr_accessible :name, :others, :generators, :huslab

  def infoForSelectBox

    self.name

  end

end
