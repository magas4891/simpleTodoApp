# frozen_string_literal: true

ActiveRecord::Schema.define(version: 2021_01_03_175057) do
  enable_extension 'plpgsql'

  create_table 'projects', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.date 'deadline'
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_projects_on_user_id'
  end

  create_table 'tasks', force: :cascade do |t|
    t.string 'description'
    t.boolean 'done', default: false
    t.bigint 'project_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'position'
    t.index ['project_id'], name: 'index_tasks_on_project_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'],
            name: 'index_users_on_reset_password_token',
            unique: true
  end

  add_foreign_key 'projects', 'users'
  add_foreign_key 'tasks', 'projects'
end
