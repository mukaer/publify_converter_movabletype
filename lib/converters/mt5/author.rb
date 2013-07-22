module MT5
  class Author < ActiveRecord::Base
    set_table_name 'mt_author'
    set_primary_key 'author_id'
    establish_connection configurations['mt5']
    has_many :entry, :foreign_key => 'entry_author_id', :class_name => 'MT5::Entry'

  end
end
