class RecipesController < ApplicationController
    def index
        recipes = Recipe.all 
        if session[:user_id]
          render json: recipes, status: :ok
        else
          render json: { errors: [] }, status: :unauthorized
        end
      end
      def create
        if session[:user_id]
            user = User.find(session[:user_id])
            recipe = user.recipes.new(recipe_params)
            if recipe.valid?
                recipe.save!
                render json: recipe, status: :created
              else
                render json: { errors: [] }, status: :unauthorized
              end
            else
             
              render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
            end
          end
        
          private
        
          def recipe_params
            params.permit(:title, :instructions, :minutes_to_complete)
          end

    
      end
end
