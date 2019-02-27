class CreateUsuarioPerfis < ActiveRecord::Migration[5.2]
  def change
    create_table :usuario_perfis do |t|
      t.references :usuarios, foreign_key: true
      t.references :perfis, foreign_key: true

      t.timestamps
    end
  end
end
