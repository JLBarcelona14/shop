const express = require('express');
const app = express('express');
const fs = require('fs');
const Joi = require('joi');

// 
const Product = require('./controller/product.js');
const Order = require('./controller/order.js');


app.use(express.json());

app.get('/get/order', (req, res) => {
    let ord = new Order();
    let order = ord.get();
    // res.send(order);
    res.send("Check console");
    console.log(order);
    // console.log("No order found!");
});


// Order
app.post('/save/order', (req, res) => {
    const { error } = order_validator(req.body);
    if (error) {
        res.status(400).send(error.details[0].message);
        return;
    }

    let data = {
        product_id: req.body.product_id,
        customer_id: req.body.customer_id,
    }
    let ord = new Order(data);
    let order = ord.save();
    // res.send(order);
    res.send(ord.get());
    console.log(order);
}); 

app.get('/find/order/:id', (req, res) => {
    const valid_id = order_id_validator(req.params.id);
    if (!valid_id)  return res.status(404).send('The Order ID is not exist!');

    let ord = new Order(req.params.id);
    // res.send(order);
    res.send(ord.find());
    console.log(ord.find());
});

app.put('/received/order/:id', (req, res) => {
    const valid_id = order_id_validator(req.params.id);
    if (!valid_id)  return res.status(404).send('The Order ID is not exist!');

    let ord = new Order(req.params.id);
    let order = ord.recieved();
    // res.send(order);
    res.send(ord.find());
    console.log(order);
});

app.delete('/delete/order/:id', (req, res) => {
     const valid_id = order_id_validator(req.params.id);
    if (!valid_id)  return res.status(404).send('The Order ID is not exist!');

    let ord = new Order(req.params.id);
    let order = ord.delete();
    // res.send(ord);
    res.send(ord.get());
    console.log(ord);
});

// Product
app.post('/save/product/', (req, res) => {
    const { error } = Product_Validator(req.body);
    if (error) {
        res.status(400).send(error.details[0].message);
        return;
    }

    let data = {
        product_name: req.body.product_name,
        category: req.body.category,
    }
    let pr = new Product(data);
    let prod = pr.save();
    // res.send(prod);
    res.send(pr.get());
    console.log(prod);
});

app.put('/update/product/:id', (req, res) => {

    const valid_id = product_id_validator(req.params.id);
    if (!valid_id)  return res.status(404).send('The Product ID is not exist!');

    const { error } = Product_Validator(req.body);
    if (error) {
        res.status(400).send(error.details[0].message);
        return;
    }

    let data = {
        product_id: req.params.id,
        product_name: req.body.product_name,
        category: req.body.category,
    }

    let pr = new Product(data);
    let prod = pr.update();
    let prs = new Product(req.params.id);
    // res.send(prod);
    res.send(prs.find());
    console.log(prod);
});

app.get('/get/product', (req, res) => {
    let pr = new Product();
    let prod = pr.get();
    
    // res.send(prod);
    res.send(prod);
    console.log(prod);
});

app.get('/find/product/:id', (req, res) => {
    const valid_id = product_id_validator(req.params.id);
    if (!valid_id)  return res.status(404).send('The Product ID is not exist!');

    let pr = new Product(req.params.id);
    let prod = pr.find();
    
    // res.send(prod);
    res.send(prod);
    console.log(prod);
});

app.delete('/delete/product/:id', (req, res) => {
    const valid_id = product_id_validator(req.params.id);
    if (!valid_id)  return res.status(404).send('The Product ID is not exist!');

    let pr = new Product(req.params.id);
    let prod = pr.delete();
    
    // res.send(prod);
    res.send(pr.get());
    console.log(prod);
});

app.listen(4000, () => {
    console.log("running server 4000");
});


function Product_Validator(product){
    const schema = Joi.object({
        product_name : Joi.string().min(5).required(),
        category : Joi.string().min(5).required()
    }); 

    return schema.validate(product);
}

function product_id_validator(id){
    let products = new Product();
    let prod = products.get();

    const has_product = prod.find(p => p.product_id === parseInt(id));
    return has_product;
}


function order_validator(order){
    const schema = Joi.object({
        product_id : Joi.number().required(),
        customer_id : Joi.number().required()
    }); 

    return schema.validate(order);
}

function order_id_validator(id){
    let orders = new Order();
    let ord = orders.get();

    const has_order = ord.find(o => o.order_id === parseInt(id));
    return has_order;
}