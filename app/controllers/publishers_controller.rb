class PublishersController < ApplicationController
  before_action :set_publisher, only: [ :show, :destroy, :index ]
    def index
      @publishers = Publisher.all
      @publisher = Publisher.new
    end

    def show
      @publisher = Publisher.find_by_id(params[:id])
      @events = Event.where(publisher_id: @publisher.id) if @publisher
      @event = Event.new
    end

    def new
      @publisher = Publisher.new
    end

    def create
      puts "Received params: #{params.inspect}"
      @publisher = Publisher.new(publisher_params)

      if @publisher.save
        redirect_to @publisher, notice: "Publisher was successfully created."
      else
      render :new, status: :unprocessable_entity
      end
    end

    def edit
      @publisher = Publisher.find_by_id(params[:id])
      if @publisher.nil?
        redirect_to publishers_path, alert: "Publisher not found."
      end
    end


    def update
      @publisher = Publisher.find_by_id(params[:id])
      if @publisher.nil?
        redirect_to publishers_path, alert: "Publisher not found."
        return
      end

      if @publisher.update(publisher_params)
        redirect_to @publisher, notice: "Publisher was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end


    def destroy
      if @publisher
        @publisher.destroy
        redirect_to publishers_path, notice: "Publisher was successfully deleted."
      else
        redirect_to publishers_path, alert: "Publisher not found."
      end
    end

    private
    def set_publisher
      @publisher = Publisher.find_by_id(params[:id])
    end
    def publisher_params
      params.require(:publisher).permit(:title, :description)
    end
end
