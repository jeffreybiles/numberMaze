class CreateUserAndIdentityWithOmniauth < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :identity_id
      t.integer :money
      t.integer :time_increases
    end

    create_table :skills do |t|
      t.string :name
    end

    create_table :skill_levels do |t|
      t.integer :skill_id
      t.integer :user_id
      t.integer :level
      t.integer :experience
    end

    create_table :identities do |t|
      t.string :email
      t.string :password_digest
      t.string :name
    end

    create_table :switches do |t|
      t.string :name
      t.text :effect #could I.... store code here?  :O
    end

    create_table :switch_flips do |t|
      t.integer :switch_id
      t.integer :user_id

      t.timestamps
    end
  end
end
