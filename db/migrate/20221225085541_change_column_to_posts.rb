class ChangeColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :lat, false
    change_column_null :posts, :lng, false
  end  
end
