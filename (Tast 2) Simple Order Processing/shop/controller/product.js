const fs = require('fs');
let pr = require('../json/product.json');


function Product(data = []) {
    return{
        get: () => {
            let product =  pr.product;
            let prods = product.map(prod => {
                return prod
            });
            return prods;
        },
        save: () => {
            let last_id_ = pr.product.length
            let last_id = (last_id_ > 0)? (pr.product[last_id_ - 1].product_id + 1) : 1;
            data["product_id"] = last_id;
            pr.product.push(data);
            let pp = JSON.stringify(pr);
            return save_data(pp, "Product saved Successfully!");
        },
        delete: () => {
            let product =  pr.product;
            let i = 0;
            let prods = product.map(prod => {
                if(prod.product_id == data){
                    return product.splice(i, 1);
                }
                i++;
            });
            pr["product"] = prods;
            pr["product"] = product;
            let new_data =  JSON.stringify(pr);
            return save_data(new_data, "Product deleted Successfully!");
        },
        update: () => {
            let id = data.product_id;
            let product =  pr.product;
            let i = 0;
            let prods = product.map(prod => {
                if(prod.product_id == id){
                    prod.product_name = data.product_name;
                    prod.category = data.category;
                }                
                return prod;
            });
            pr["product"] = prods;
            pr["product"] = product;
            let new_data =  JSON.stringify(pr);
            // console.log(pr);
            return save_data(new_data, "Product updated Successfully!");
        },
        find: () => {
            let product =  pr.product;
            let i = 0;
            let key = 0;
            let prods = product.map(prod => {
                if(prod.product_id == data){
                    key = i;
                    return prod;
                }
                i++;
            });

            return prods[key];

        }
    }
}

function save_data(pp,msg){
    fs.writeFile('./json/product.json', pp, 'utf8', function(err){
        if(err){ 
            console.log(err);
        } else {
            console.log(msg);
    }});
}

module.exports = Product