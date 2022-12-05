class LocationsController < ApplicationController
  def index
    points = Location.all

    render json: points.to_json(include: { charging_stations: { include: :connectors } }), status: 200
  end
end
