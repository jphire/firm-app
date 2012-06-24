# encoding: utf-8
class RecipesController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin
  before_filter :admin_user, only: []

  def index
    list = []
    @bakery.recipes.each { |e| list.push e.id }
    sql = " SELECT *
      FROM recipes AS r
      WHERE r.id IN (#{list.join(',')})"
        
    @recipes = Recipe.paginate_by_sql(sql, :page => params[:page], :per_page => 3)
  end
  
  def show
    @hasmaterials = @recipe.hasmaterials
    @bakery = @recipe.bakery
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.bakery = @bakery
    
    if @recipe.save
      if params[:new_materials]
        params[:new_materials].each do |material|
          Hasmaterial.create(:material_id => material[0], :recipe_id => @recipe.id, :amount => material[1])      
        end
      end
      @recipe.update_price
      
      flash[:success] = "Uusi resepti luotu!"
      redirect_to @recipe
    else
      #debugging
      #flash[:error] = params
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    Hasmaterial.destroy_all(:recipe_id => @recipe.id)
    if params[:old_materials]
      params[:old_materials].each do |material|
        Hasmaterial.create(:material_id => material[0], :recipe_id => @recipe.id, :amount => material[1])
      end
    end
    
    if params[:new_materials]
      params[:new_materials].each do |material|
        Hasmaterial.create(:material_id => material[0], :recipe_id => @recipe.id, :amount => material[1])     
      end
    end
    
    if @recipe.update_attributes(params[:recipe]) && @recipe.save
      @recipe.update_price
      flash[:success] = "Resepti tallennettu"
      redirect_to @recipe
    else 
      flash.now[:error] = "Reseptin tallennus ei onnistunut."
      render 'edit'
    end
  end
  
  def destroy
    @recipe.destroy
    flash[:success] = "Resepti poistettu."
    redirect_to @bakery
  end
  
  private
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Kirjaudu sisään kiitos."
      end
    end
    
    def firm_admin
      
      @added_materials = []
      @tax = 0.13
      if params[:id]
        @recipe = Recipe.find(params[:id])
        @bakery = @recipe.bakery
      elsif params[:bakery_id]
        @bakery = Bakery.find_by_id(params[:bakery_id])
        if !@bakery
          @recipe = nil
        end
      end
      
      if @recipe and @recipe.bakery
        admins = @recipe.bakery.firm.users #later change to include only admins
      elsif @bakery
        admins = @bakery.firm.users #later change to include only admins
      else
        flash[:error] = "Ei lupaa tehdä muutoksia." 
        admins = []
      end
      redirect_to(root_path) unless admins.include? current_user
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end  
end