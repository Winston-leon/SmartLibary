package com.ssm.maven.core.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
/**
 * @author 1034683568@qq.com
 * @project_name ssm-maven
 * @date 2017-3-1
 */
public class Book implements Serializable {
    private String id;// 主键id
    private String isbn;// ISBN码
    private String image_path;// 图片
    private String title;// 标题
    private String subtitle;// 副标题
    private String version;//版本
    private String author;// 作者
    private String translator;// 译者
    private String publishing_year;// 出版年份
    private BigDecimal price;// 价格
    private String press;// 出版社
    private Integer page;// 页数
    private String binding;// 装帧
    private Integer status;// 状态
    private String description;// 简介

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getImagePath() {
        return image_path;
    }

    public void setImagePath(String image_path) {
        this.image_path = image_path;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTranslator() {
        return translator;
    }

    public void setTranslator(String translator) {
        this.translator = translator;
    }

    public String getPublishingYear() {
        return publishing_year;
    }

    public void setPublishingYear(String publishing_year) {
        this.publishing_year = publishing_year;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getPress() {
        return press;
    }

    public void setPress(String press) {
        this.press = press;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public String getBinding() {
        return binding;
    }

    public void setBinding(String binding) {
        this.binding = binding;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    @Override
    public String toString() {
        return "Book{" +
                "id='" + id + '\'' +
                ", isbn='" + isbn + '\'' +
                ", image_path='" + image_path + '\'' +
                ", title='" + title + '\'' +
                ", subtitle='" + subtitle + '\'' +
                ", version='" + version + '\'' +
                ", author'" + author + '\'' +
                ", translator='" + translator + '\'' +
                ", publishing_year='" + publishing_year + '\'' +
                ", price='" + price + '\'' +
                ", press='" + press + '\'' +
                ", page='" + page + '\'' +
                ", binding='" + binding + '\'' +
                ", status=" + status +
                ", description='" + description + '\'' +
                '}';
    }
}
