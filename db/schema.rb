# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_26_211229) do

  create_table "odisseias", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "texto"
    t.text "fonte"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfis", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissoes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "recursos_id"
    t.bigint "perfis_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfis_id"], name: "index_permissoes_on_perfis_id"
    t.index ["recursos_id"], name: "index_permissoes_on_recursos_id"
  end

  create_table "recursos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.string "descricao"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuario_perfis", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "usuarios_id"
    t.bigint "perfis_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfis_id"], name: "index_usuario_perfis_on_perfis_id"
    t.index ["usuarios_id"], name: "index_usuario_perfis_on_usuarios_id"
  end

  create_table "usuarios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  add_foreign_key "permissoes", "perfis", column: "perfis_id"
  add_foreign_key "permissoes", "recursos", column: "recursos_id"
  add_foreign_key "usuario_perfis", "perfis", column: "perfis_id"
  add_foreign_key "usuario_perfis", "usuarios", column: "usuarios_id"
end
