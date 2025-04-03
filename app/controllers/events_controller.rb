class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :set_publishers, only: %i[new edit create update]

  def index
    @events = Event.includes(:publisher).all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to publishers_url(@event.publisher_id), notice: "Event was successfully deleted."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_publishers
    @publishers = Publisher.all
  end

  def event_params
    params.require(:event).permit(:title, :start_datetime, :end_datetime, :recurrence_rule, :publisher_id, :recurring)
  end
end
