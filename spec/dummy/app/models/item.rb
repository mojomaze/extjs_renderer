class Item < ActiveRecord::Base
  belongs_to :order
  
  def as_json(options=nil)
    serializable_hash({:only => [:id, :name] })
  end
  
end
