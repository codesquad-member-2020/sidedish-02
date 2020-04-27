import React from 'react';
import DishList from './DishList';

const DishWrap = ({ dishes, category, description, bold }) => {

    return (
        <>
            <p className="category">{category}</p>
            <span className="category-description">{description} <span className="bold">{bold}</span>
            </span>
            <div className="item_slide-wrap">
                <DishList dishes={dishes} />
            </div>
        </>
    )
}
export default DishWrap