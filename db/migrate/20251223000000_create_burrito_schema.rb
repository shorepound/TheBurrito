class CreateBurritoSchema < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :first_name
      t.string :last_name
      t.string :password_digest, limit: 60
      t.integer :is_admin, limit: 1, default: 0, null: false

      t.timestamps
    end

    create_table :tortillas do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :sizes do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :fillings do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :toppings do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :burritos do |t|
      t.references :user, foreign_key: true, null: false
      t.references :tortilla, foreign_key: true, null: false
      t.references :size, foreign_key: true, null: false
      t.string :name
      t.timestamps
    end

    create_table :burrito_fillings do |t|
      t.references :burrito, foreign_key: true, null: false
      t.references :filling, foreign_key: true, null: false
      t.timestamps
    end

    create_table :burrito_toppings do |t|
      t.references :burrito, foreign_key: true, null: false
      t.references :topping, foreign_key: true, null: false
      t.timestamps
    end
  end
end
