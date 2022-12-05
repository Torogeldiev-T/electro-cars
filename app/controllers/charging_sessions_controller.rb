class ChargingSessionsController < ApplicationController
  def index
    charging_sessions = ChargingSession.all

    render json: charging_sessions, status: 200
  end

  def show
    charging_session = ChargingSession.find_by_id(params[:id])

    if charging_session
      render json: charging_session.to_json(methods: %i[location_name user_full_name user_phone_number]),
             status: 201
    else
      render json: { error: 'Session Not Found.' }, status: 404
    end
  end

  def create
    connector = Connector.find_by_id(params[:connector_id])
    user = User.find_by_id(params[:user_id])

    if connector && user
      charging_session = ChargingSession.create(connector:, user:)
      
      if charging_session.errors.empty?
        render json: charging_session, status: 201, location: charging_session_path(charging_session)
      else
        render json: { error: charging_session.errors.full_messages.join(".\n") }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Connector Or User Not Found.' }, status: 400
    end
  end

  def stop
    charging_session = ChargingSession.find_by_id(params[:id])

    if charging_session
      charging_session.stop

      if charging_session.errors.empty?
        render json: charging_session, status: 200, location: charging_session_path(charging_session)
      else
        render json: { error: charging_session.errors.full_messages.join("\n") }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Session Not Found.' }, status: 404
    end
  end
end
