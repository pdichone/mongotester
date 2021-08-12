const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const productSchema = new Schema ({
name: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    price: {
        type: Number,
        min: [1],
        required: true,
    },
    discount: {
        type: Number,
        min: [1],
        required: false,
    },
    created_at: {type: Date, default: Date.now},
     updated_at: {type: Date, default: Date.now()}
});
module.exports = mongoose.model('Product', productSchema);