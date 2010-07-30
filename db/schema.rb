ActiveRecord::Schema.define(:version => 1) do
  
  begin
    drop_table :users
    drop_table :follow
  rescue
    puts $!
  end
  
  create_table :users, :force => true do |t|
    t.string :login
  end
  
  create_table :follows, :force => true do |t|
    t.string    :follower_type
    t.integer   :follower_id
    t.string    :followed_type
    t.integer   :followed_id
    t.boolean   :approved, :default => false
    t.timestamps
  end
  
  add_index :follows, :follower_id
  add_index :follows, :followed_id
end