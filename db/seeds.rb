# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
    id:1,
    first_name: 'admin',
    last_name: 'admin',
    email: 'skif_lg@ukr.net',
    password_digest: '$2a$10$3zykKntipkPx300G2Qj5S.i1xlDMTBdArD5YRBw5rPYsqPOuwjDm.',
    activated: true
)

GroupAdmin.create(
    id: 1,
    name: 'default',
    user: 1,
    admin: 1,
    group_admin: 0
)

group_admin = GroupAdmin.create(
    id: 2,
    name: 'master',
    user: 3,
    admin: 3,
    group_admin: 3
)

Admin.create(
         id: 1,
         user_id: user.id,
         group_admin_id: group_admin.id
)

