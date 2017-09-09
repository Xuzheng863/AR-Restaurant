const RestaurantsController = require('../controllers/restaurants_controller');

module.exports = (app) => {
  app.get('/api/restaurants', RestaurantsController.create);
  app.get('/api/restaurants_fetch', RestaurantsController.fetch_restaurants);
};
