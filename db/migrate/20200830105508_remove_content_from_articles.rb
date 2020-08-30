class RemoveContentFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :content, :text
    # 方（text）を指定する必要がある schemaで確認
  end
end
