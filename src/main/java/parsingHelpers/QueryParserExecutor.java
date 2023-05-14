package parsingHelpers;

import mainClasses.DBApp;
import mainClasses.DBAppException;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import sqlAntlrParser.QueryLexer;
import sqlAntlrParser.QueryParser;

public class QueryParserExecutor {
    private DBApp app;
    private String query;
    private QueryVisitorHelper qvh;
    public QueryParserExecutor(DBApp app , String query){
        this.app = app;
        this.query = query.toUpperCase();
        this.qvh = new QueryVisitorHelper();
    }
    private void visitQuery(){
        QueryLexer q = new QueryLexer(CharStreams.fromString(this.query));
        CommonTokenStream commonTokenStream = new CommonTokenStream(q);
        QueryParser parser = new QueryParser(commonTokenStream);
        qvh.visit(parser.sql_query());
    }

    public void queryExecute() throws DBAppException {
        visitQuery();
        switch(qvh.getStatement_Type()){
            case "select": selectQuery(); break;
            case "createindex": createIndexQuery();break;
            case "delete": deleteQuery(); break;
            case "update": updateQuery(); break;
            default: throw new DBAppException("This Query isn't supported!");
        }
    }
    public void selectQuery(){
        System.out.println(qvh.getSelectConditions());
        System.out.println((qvh.getSelectColumnOperators()));
        System.out.println("Select!!!!!!!!!!!!!!1");
    }
    public void createIndexQuery(){
        System.out.println(qvh.getCreateIndexColumns());
        System.out.println(qvh.getTableName());
        System.out.println("createIndex!!!!!!!!!!!!!!!!!!!!!");
    }
    public void deleteQuery(){
        System.out.println(qvh.getUpdateDeleteColumnNames());
        System.out.println(qvh.getUpdateDeleteObjectValues());
        System.out.println("Delete!!!!!!!!!!!!!!!!!!!!!");
    }
    public void updateQuery(){
        System.out.println(qvh.getUpdateDeleteColumnNames());
        System.out.println(qvh.getUpdateDeleteObjectValues());
        System.out.println(qvh.getUpdateColumnToSetNames());
        System.out.println(qvh.getUpdateColumToSetValues());
    }
    public static void main(String[] args) throws DBAppException {
        QueryParserExecutor qf = new QueryParserExecutor(null , "Update Students set name = 'Karim' , gpa = '0.7' where age = 10");
        qf.queryExecute();
    }

}