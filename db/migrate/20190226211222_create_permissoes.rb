class CreatePermissoes < ActiveRecord::Migration[5.2]
  def change
    create_table :permissoes do |t|
      t.references :recursos, foreign_key: true
      t.references :perfis, foreign_key: true

      t.timestamps
    end
  end
end
