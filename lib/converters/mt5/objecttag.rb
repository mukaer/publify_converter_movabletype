# -*- coding: utf-8 -*-
module MT5
  class Objecttag  < ActiveRecord::Base
    
    set_table_name   'mt_objecttag'
    set_primary_key  'objecttag_id'    
    establish_connection configurations['mt5']

    belongs_to :entry ,:foreign_key =>'objecttag_entry_id'
    belongs_to :tag   ,:foreign_key =>'objecttag_tag_id'
    


  end
end
