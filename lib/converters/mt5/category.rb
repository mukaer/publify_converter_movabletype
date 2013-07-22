# -*- coding: utf-8 -*-
module MT5
  class Category  < ActiveRecord::Base
    
    set_table_name   'mt_category'
    set_primary_key  'category_id'    
    establish_connection configurations['mt5']


    has_many :entry ,:through => :placement, :class_name => 'MT5::placement'
    has_many :placement , :foreign_key => 'placement_category_id'

  end
end
