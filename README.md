Publify 6.1 converter from MovableType 5
========================================

This is Blog engine Publify plugin. Convert Publify Database from MovableType Dababase.
Use ActiveRecord.

* [GitHub Publify](https://github.com/fdv/publify)

## install

### 1.Get Source Code

    cd publify/lib
    git clone https://github.com/mukaer/publify_converter_movabletype.git

### 2.Copy application.rb

    cp publify_converter_movabletype/application.rb config/application.rb


### 3.Edit database.yml

`publify/config/database.yml` edit. add mt5 database config.


    mt5:
      database: mt5
      adapter:  mysql2
      host:     localhost
      username: root
      password: 


## Use runscript

./script/rails runner "Converter.convert_from :mt5"
