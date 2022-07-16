class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles, id: :uuid do |t|
      t.integer :external_id
      t.string :title
      t.string :description
      t.string :section
      t.boolean :current
      t.boolean :liked, default: false
      t.string :expiry

      t.timestamps
    end
  end
end
