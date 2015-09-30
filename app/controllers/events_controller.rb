class EventsController < ApplicationController
  def index
    @events = Event.reorder("happen_at ASC").paginate(page: params[:page], per_page: 10)
    authorize @events
  end

  def show
    @event = Event.find(params[:id])
    @user = @event.user
    authorize @event
  end

  def new
    @user = current_user
    @event = Event.new
    authorize @event
  end

  def create
    @user = current_user
    @event = current_user.events.build(event_params)
    authorize @event
    if @event.save
      flash[:notice] = "Event was created."
      redirect_to [@event]
    else
      flash[:error] = "There was an error saving the event.Please try again."
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    @user = User.find(@event.user_id)
    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    @user = User.find(@event.user_id)
    authorize @event

    if @event.update_attributes(event_params)
      flash[:notice] = "Event #{@event.title} was updated."
      redirect_to [@event]
    else
      flash[:error] = "There was error updating the event"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      flash[:notice] = "Event was canceled successfully"
      redirect_to events_path
    else
      flash[:error] = "There was an error deleting the event"
      render :show
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :title,
      :type_event,
      :description,
      :to_bring,
      :minimum_participants,
      :happen_at,
      :duration,
      :privacy,
      :location,
      :user_id
    )
  end
end
