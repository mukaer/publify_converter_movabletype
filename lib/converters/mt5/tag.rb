# -*- coding: utf-8 -*-
module MT5
  class Tag  < ActiveRecord::Base
    
    set_table_name   'mt_tag'
    set_primary_key  'tag_id'    
    establish_connection configurations['mt5']

    has_many :objecttag, :foreign_key =>'objecttag_tag_id',:class_name =>'MT5::Objecttag'
    has_many :entry     ,:through => :objcttag  ,:class_name =>'MT5::Entry'



  end
end
