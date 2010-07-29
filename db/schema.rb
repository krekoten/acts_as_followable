ActiveRecord::Schema.define(:version => 1) do
  
  begin
    drop_table :users
    drop_table :follows
  rescue
    puts $!
  end
  
  create_table :users, :force => true do |t|
    t.string :login
  end
  
  create_table :follows, :force => true do |t|
    t.string    :followers_type
    t.integer   :followers_id
    t.string    :follows_type
    t.integer   :follows_id
    t.boolean   :approved, :default => false
    t.timestamps
  end
  
  add_index :follows, :followers_id
  add_index :follows, :follows_id
end