const RestaurantsController = require('../controllers/restaurants_controller');

module.exports = (app) => {
  app.get('/api/restaurants', RestaurantsController.create);
};
