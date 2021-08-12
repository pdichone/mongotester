const Product = require("./server/model/product");
module.exports = {
  products: async function () {
    const products = await Product.find();
    return {
      products: products.map((q) => {
        return {
          ...q._doc,
          _id: q._id.toString(),
        };
      }),
    };
  },
  updateProduct: async function ({ id, productInput }) {
    const product = await Product.findById(id);
    if (!product) {
      throw new Error('Product Not found!');
    }
    
    product.name = productInput.name;
    product.description = productInput.description;
    product.price = productInput.price;
    product.discount = productInput.discount;
    const updatedProduct = await product.save();
    return {
      ...updatedProduct._doc,
      _id: updatedProduct._id.toString(),
    };
  },
  deleteProduct: async function ({ id, productInput }) {
    const product = await Product.findById(id);
    if (!product) {
      throw new Error('Product Not found!');
    }
    await Product.findByIdAndRemove(id);
    return {
      ...product._doc,
      id: product._id.toString(),
    };
  },
  
  createProduct: async function ({ productInput }) {
    const product = new Product({
      name: productInput.name,
      description: productInput.description,
      price: productInput.price,
      discount: productInput.discount,
    });
    const createdProduct = await product.save();
    return {
      ...createdProduct._doc,
      _id: createdProduct._id.toString(),
    };
  },
};
