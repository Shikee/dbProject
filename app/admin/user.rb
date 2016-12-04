ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end



  index do
    column :id
    column :email do |a|
     link_to a.email ,user_path(a.id)
   end
    column :name
    column :nickname
    column :sex
    column :birth
    column :is_admin
    column :age
    column :role
    column :created_at

  end
end
