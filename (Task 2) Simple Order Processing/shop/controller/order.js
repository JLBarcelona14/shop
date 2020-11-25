const fs = require('fs');
let ord = require('../json/order.json');


function Order(data = []) {
    return{
        get: () => {
            let order =  ord.order;
            let ords = order.map(ord => {
                return ord
            });
            return ords;
        },
        save: () => {
            let last_id_ = ord.order.length
            let last_id = (last_id_ > 0)? (ord.order[last_id_ - 1].order_id + 1) : 1;
            data["order_id"] = last_id;
            data["status"] = "pending";
            ord.order.push(data);
            let pp = JSON.stringify(ord);
            return save_data(pp, "order saved Successfully!");
        },
        delete: () => {
            let order = ord.order;
            let i = 0;
            let ords = order.map(ord => {
                if(ord.order_id == data){
                    return order.splice(i, 1);
                }
                i++;
            });
            ord["order"] = ords;
            ord["order"] = order;
            let new_data =  JSON.stringify(ord);
            return save_data(new_data, "order deleted Successfully!");
        },
        update: () => {
            let id = data.order_id;
            let order =  ord.order;
            let i = 0;
            let ords = order.map(ord => {
                if(ord.order_id == id){
                    ord.order_name = data.order_name;
                    ord.category = data.category;
                }                
                return ord;
            });
            ord["order"] = ords;
            ord["order"] = order;
            let new_data =  JSON.stringify(or);
            // console.log(pr);
            return save_data(new_data, "order updated Successfully!");
        },
        recieved: () => {
            let order =  ord.order;
            let i = 0;
            let ords = order.map(ord => {
                if(ord.order_id == data){
                    ord.status = "Received";
                }                
                return ord;
            });
            ord["order"] = ords;
            ord["order"] = order;
            let new_data =  JSON.stringify(ord);
            // console.log(pr);
            return save_data(new_data, "Order recieved successfully!");
        },
        find: () => {
            let order = ord.order;
            let i = 0;
            let key = 0;
            let ords = order.map(ord => {
                if(ord.order_id == data){
                    key = i;
                    return ord;
                }
                i++;
            });
            return ords[key];
        }
    }
}

function save_data(data,msg){
    fs.writeFile('./json/order.json', data, 'utf8', function(err){
        if(err){ 
            console.log(err);
        } else {
            console.log(msg);
    }});
}

module.exports = Order