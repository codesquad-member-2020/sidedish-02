import React, { useState, useEffect } from 'react';
import URL from '../constants/url';


const DishDetail = ({ targetId }) => {
    const [targetDish, setTargetDish] = useState([]);

    const fetchInitialData = async () => {
        const targetDishData = await fetchJSON(URL.MOCK.DETAIL_API + targetId);
        console.log(targetDishData.data.product_description)
        setTargetDish(targetDishData.data);
    }

    useEffect(() => {
        fetchInitialData();
    }, [])


    return (
        <div>
            {targetDish.product_description}
            {/* {targetId} */}
        </div>

    )
}

const fetchJSON = (url) => {
    return fetch(url)
        .then(response => {
            return response.json();
        });
}

export default DishDetail
