class EventsController < ApplicationController
  before_action :set_publisher
  before_action :set_event, only: [ :edit, :update, :destroy, :create ]

  def destroy
    if @event
      @event.destroy
      redirect_back fallback_location: publisher_path(@event.publisher_id), notice: "Event was successfully deleted."
    else
      redirect_back fallback_location: publisher_path(@event.publisher_id), alert: "Event not found."
    end
  end



  def set_event
    @event = Event.find_by(id: params[:id])
  end
    def index
      @events = Event.all
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      if @event.save
        redirect_to publisher_path(@event.publisher_id), notice: "Event created successfully."
      else
        render :new
      end
    end

    def edit
      if @event.nil?
        redirect_to publishers_path, alert: "Event not found."
      end
    end

    def update
      if @event.update(event_params)
        redirect_to publisher_path(@event.publisher), notice: "Event was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def set_publisher
      @publisher = Publisher.find_by_id(params[:publisher_id])
    end

    private

    def event_params
      params.require(:event).permit(:title, :start_datetime, :end_datetime, :recurrence, :publisher_id)
    end
end
