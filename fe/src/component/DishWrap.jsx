import React from 'react'
import DishList from './DishList';

const DishWrap = ({ dishes, category, description, bold }) => {

    return (
        <>
            <p className="category">{category}</p>
            <span className="category-description">{description} <span className="bold">{bold}</span>
            </span>
            <div className="item_slide-wrap">
                <button>&lt;</button>
                <DishList dishes={dishes} />
                <button>&gt;</button>
            </div>
        </>
    )
}
export default DishWrap