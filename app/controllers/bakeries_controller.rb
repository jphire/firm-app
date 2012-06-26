# encoding: utf-8
class BakeriesController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin
  before_filter :admin_user,     only: [:new, :create, :destroy]
  
  def show
    @bakery = Bakery.find(params[:id])
    @firm = Firm.find(@bakery.firm.id)
    
    if params[:search_recipe]
      q = params[:search_recipe]
      @recipes = @bakery.recipes.paginate(:page => params[:recipe_page], :per_page => 10, :conditions => ['name like ?', "%#{q.downcase}%"]).order('name')
      @materials = @bakery.materials.paginate(:page => params[:page], :per_page => 5).order('name')
    elsif params[:search_material]
      q = params[:search_material]
      @recipes = @bakery.recipes.paginate(:page => params[:page], :per_page => 10).order('name')
      @materials = @bakery.materials.paginate(:page => params[:material_page], :per_page => 5, :conditions => ['name like ?', "%#{q.downcase}%"]).order('name')
    else
      @recipes = @bakery.recipes.paginate(:page => params[:recipe_page], :per_page => 10).order('name')
      @materials = @bakery.materials.paginate(:page => params[:material_page], :per_page => 5).order('name')
    end
    @users = @firm.users.paginate(:page => params[:page], :per_page => 5).order('name')
  end
  
  def index
    if current_user.admin?
      @bakeries = Firm.paginate(page: params[:page], per_page:10)
    else
      sql = " SELECT *
      FROM firms AS f
      WHERE f.id IN (SELECT u.firm_id 
        FROM firms_users AS u 
        WHERE user_id='#{current_user.id}') AND f.resource_type='Bakery'"
      @bakeries = Firm.paginate_by_sql(sql, :page => params[:page])
    end
  end
  
  private
       
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Kirjaudu sisään."
      end
    end
    
    def firm_admin
      @tax = 0.13
      if params[:id]
        @bakery = Bakery.find(params[:id])
        if @bakery and @bakery.firm 
          @firm = @bakery.firm
          admins = @firm.users #later change to include only admins
        else
          flash[:error] = "Ei lupaa tehdä muutoksia." 
          admins = []
        end
      end
      redirect_to(root_path) unless admins.include? current_user
    end
    
    def admin_user
      if current_user
        redirect_to(root_path) unless current_user.admin?
      else
        redirect_to(root_path)
      end
    end
  
end
