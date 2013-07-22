module MT5
  class Entry  < ActiveRecord::Base
    
    set_table_name   'mt_entry'
    set_primary_key  'entry_id'    
    establish_connection configurations['mt5']

    has_many :tag       ,:through => :objecttag  ,:class_name =>'MT5::Tag'
    has_many :objecttag, :foreign_key =>'objecttag_object_id', :class_name =>'MT5::Objecttag'

    
    has_many :category  ,:through => :placement ,:class_name  =>'MT5::Category'
    has_many :placement, :foreign_key =>'placement_entry_id', :class_name =>'MT5::Placement'
    

    def tags
      objecttag_for
    end

    private

    def  objecttag_for
      tag.map do |t|
       t.tag_name
      end.compact
    end
  end
end
