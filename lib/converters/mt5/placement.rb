# -*- coding: utf-8 -*-
module MT5
  class Placement  < ActiveRecord::Base
    
    set_table_name   'mt_placement'
    set_primary_key  'placement_id'    
    establish_connection configurations['mt5']


    belongs_to  :entry    , :foreign_key => 'placement_entry_id'   ,:class_name => 'MT5::Entry'
    belongs_to  :category , :foreign_key => 'placement_category_id',:class_name => 'MT5::Category'

  end
end
