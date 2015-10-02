class EventsController < ApplicationController
  def index
    @events = Event
      .where("happen_at >= ?", Date.today)
      .reorder("happen_at ASC")
      .paginate(page: params[:page], per_page: 10)
    authorize @events
  end

  def show
    @event = Event.find(params[:id])
    @user = @event.user

    if not EventParticipation.where("user_id = ?", @event.user_id)
      .where("event_id = ?", @event.id)
      .where("will_participate = ?", 1)
      .present?
      @event_participation = 1
    else
      @event_participation = 0
    end
    if @event.current_participants >= @event.maximum_participants
      @event_participation = 2
    end
    authorize @event
  end

  def new
    @user = current_user
    @event = Event.new
    authorize @event
  end

  def create
    @user = current_user
    @location = Location.new(location_params)
    @event = current_user.events.build(event_params)
    authorize @event
    if @event.save
      if @location.save!
        @event.update_attributes(:location_id => @location.id)
      end
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
    @location = Location.find(@event.location_id)
    authorize @event

    if @event.update_attributes(event_params) and
      @location.update_attributes(location_params)
      flash[:notice] = "Event #{@event.title} was updated."
      redirect_to [@event]
    else
      flash[:error] = "There was error updating the event"
      render :edit
    end
  end

  def join
    @event = Event.find(params[:id])
    @user = User.find(@event.user_id)
    if @event.maximum_participants > @event.current_participants + 1
      @event_participate = EventParticipation.new(
        event: @event, user: @user, will_participate: 1
      )
      @event.update_attributes(
        :current_participants => @event.current_participants + 1
      )
      authorize @event
      if @event_participate.save
        flash[:notice] ="You have joined the event"
        redirect_to @event
      end
    else
      flash[:error] = "This Event is full, sorry."
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
      :maximum_participants,
      :happen_at,
      :duration,
      :privacy,
      :user_id,
      :location_id
    )
  end
  def location_params
    params.require(:location).permit(
      :name, :lat, :lng
    )
  end
end
