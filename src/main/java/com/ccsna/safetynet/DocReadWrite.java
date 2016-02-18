/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ccsna.safetynet;

/**
 *
 * @author estelle
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;
import org.apache.log4j.Logger;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;

public class DocReadWrite {

    private static final Logger log = Logger.getRootLogger();

    //read from a word doc file
    public List<XWPFParagraph> readDocFile(String fileName) throws URISyntaxException, IOException {
        fileName = "/home/estelle/NetBeansProjects/CCSNA/build/web/public/aboutus.doc";
        //fileName = this.getClass().getClassLoader().getResource("").getPath() + fileName;
        //String glassfishInstanceRootPropertyName = "com.sun.aas.";
        //fileName = System.getProperty(glassfishInstanceRootPropertyName) + fileName;
        //ServletContext context = (ServletContext) getContext();
        //fileName = context.getRealPath("/WEB-INF/" + fileName);
        System.out.println("filename is : " + fileName);
        try {
            File file = new File(fileName);

            // to read a file from webcontent
            FileInputStream fis = new FileInputStream(file.getAbsolutePath());

            XWPFDocument document = new XWPFDocument(fis);

            List<XWPFParagraph> paragraphs = document.getParagraphs();
            //return paragraphs;

            //fis.close();
            return paragraphs;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //write to a word document
    public static void writeToDocFile() {

    }
}
