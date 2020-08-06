class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false
      # 絶対に値が入っていないとダメ
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
      # null: falseオプションはvalidateのpresense:trueより強力
    end
  end
end
