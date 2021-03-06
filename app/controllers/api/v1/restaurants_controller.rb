class Api::V1::RestaurantsController < ApplicationController
    # before_action :set_restaurant, only: [:show, :update, :destroy]

    def index
        @restaurants = Restaurant.all

        render json: @restaurants, include: :burgers
    end

    def create
        @restaurant = Restaurant.new(restaurant_params)
        if @restaurant.save
            render json: @restaurant
        else    
            render json: {error: @restaurant.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show
        render json: @restaurant
    end

    def update
        if @restaurant.update(restaurant_params)
            render json: @restaurant
        else
            render json: @restaurant.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @restaurant.destroy
    end

    private

    def set_restaurant
        @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
        params.require(:restaurant).permit(:name, :location)
    end

end
