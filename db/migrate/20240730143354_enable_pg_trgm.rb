# db/migrate/XXXXXXXXXXXXXX_enable_pg_trgm.rb
class EnablePgTrgm < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pg_trgm'
  end
end
