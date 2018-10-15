package com.foodsource.apples.repository;

import com.foodsource.apples.domain.Stock;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data  repository for the Stock entity.
 */
@SuppressWarnings("unused")
@Repository
public interface StockRepository extends JpaRepository<Stock, Long> {

    @Query(value = "select distinct stock from Stock stock left join fetch stock.adverts",
        countQuery = "select count(distinct stock) from Stock stock")
    Page<Stock> findAllWithEagerRelationships(Pageable pageable);

    @Query(value = "select distinct stock from Stock stock left join fetch stock.adverts")
    List<Stock> findAllWithEagerRelationships();

    @Query("select stock from Stock stock left join fetch stock.adverts where stock.id =:id")
    Optional<Stock> findOneWithEagerRelationships(@Param("id") Long id);

}
